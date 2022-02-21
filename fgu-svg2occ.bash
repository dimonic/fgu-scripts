#!/bin/bash

if [ $# -lt 1 ]
then
  echo "Usage:\n$ $0 <svg_file>..."
  exit 1
fi

in_file="$1"
out_file=${in_file%.svg}.occ
vb_regex='viewBox="0 0 ([0-9]+) ([0-9]+)"'
smooth_distance=10

readarray content < "${in_file}"

if [[ "${content[@]}" =~ $vb_regex ]]
then
  xWide=${BASH_REMATCH[1]}
  yHigh=${BASH_REMATCH[2]}

  echo "Detected an image $xWide by $yHigh"
fi
 
let xWideMod=$xWide/2
let yHighMod=$yHigh/2

echo "<occluders>" > "${out_file}"
export occludercount=0
oc_regex='C[0-9\., \
]+Z'
coord_regex='([0-9\.,])+'


close_to_last() {
  if [ ${#array[@]} -eq 0 ]
  then
    return 0
  fi
  # echo "End of array: ${array[-1]}"
  local lastx=${array[-1]%,*}
  local lasty=${array[-1]/"$lastx,"/}
  return $(( ( ($lastx - ${coord[0]}) ** 2 + ($lasty - ${coord[1]}) ** 2 ) < ( $smooth_distance ** 2  ) ))
}

export OUT=""
chunk="${content[@]}"
while [[ "$chunk" =~ $oc_regex ]]
do
  group="${BASH_REMATCH[0]}"
  # echo "$group"
  (
    declare -a array
    declare -a coord
    while [[ "$group" =~ $coord_regex ]]
    do
      t=${BASH_REMATCH[0]%,*}
      coord[0]=${t%.*}
      t=${BASH_REMATCH[0]/"$t,"/}
      coord[1]=${t%.*}
      # echo "Found: (${coord[0]},${coord[1]})"
      close_to_last 
      if [ $? -eq 0 ]
      then
        array+=("${coord[0]},${coord[1]}")
        # echo "Added: ${array[-1]}"
      fi
      group=${group/"${BASH_REMATCH[0]}"/}
    done
    if [ ${#array[@]} -gt 1 ]
    then
      for point in ${array[@]}
      do
        coord[0]=${point%,*}
        coord[1]=${point/"${coord[0]},"/}
        # echo -n "Processing (${coord[0]},${coord[1]})"
        let modX=${coord[0]}-$xWideMod
        let modY=$yHighMod-${coord[1]}
        # echo " = ($modX,$modY)"
        OUT="${OUT}${modX},${modY},"
      done
      out=${OUT%,}
      cat <<HERE >> "$out_file"
      <occluder>
        <id>$occludercount</id>
        <points>$out</points>
        <closedpolygon>true</closedpolygon>
      </occluder>
HERE
    fi
    unset array
  )
  occludercount=$((occludercount+1))
  chunk=${chunk/"${BASH_REMATCH[0]}"/}
  # echo -n "Press enter to continue"
  # read enter
done
echo "</occluders>" >> "${out_file}"
