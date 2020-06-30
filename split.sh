#!/bin/bash
section=1
while [ $section -le 22 ]
do

    if [[ -e ${section}a.pdf || -e ${section}a1.pdf ]]
    then

        pdfunite ${section}*.pdf ${section}.pdf

        numpages=$(pdfinfo ${section}.pdf | grep Pages | awk '{print $2}')
        numdocs=$(echo "$numpages / 10" | bc)

        counter=0
        while [ $counter -le $(expr $numdocs - 1) ]
        do
            startnum=$(echo "$counter * 10 + 1"| bc)
            ((counter++))
            endnum=$(echo "$counter * 10 - 1"| bc)

            nextname="sect${section}_stud${counter}.pdf"
            pdftk ${section}.pdf cat $startnum-$endnum output output/$nextname
            echo Complete $nextname
        done

    else
        echo No section $section
    fi

    ((section++))
done

echo Splitting PDF complete
