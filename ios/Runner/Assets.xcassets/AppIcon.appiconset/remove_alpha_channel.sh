for file in *.png; do
    filename=$(basename "$file" .png)
    outputfile="${filename}_noalpha.png"
    convert "$file" -background white -alpha remove -alpha off "$outputfile"
done
