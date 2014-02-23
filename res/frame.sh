# Use imagemagick to convert from tiff screen captures to png while adding a border.

for fullname in "$@"
do
    filename=$(basename "$fullname")
    # extension="${filename##*.}"
    filename="${filename%.*}"
    outfile="$filename.png"
    echo "$fullname -> $outfile"
    convert $fullname -border 2x2 -bordercolor Gray $outfile
done
