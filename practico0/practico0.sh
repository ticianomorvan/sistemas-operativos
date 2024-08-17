# CONSTANTS
HEROES_CSV="https://raw.githubusercontent.com/dariomalchiodi/superhero-datascience/master/content/data/heroes.csv"
SUBTITLES_FOLDER=skins_subtitles

# FORMATTING
BOLD="\e[1m"
RESET="\e[0m"

# COLORS
BLACK="\e[30m"
BLUE="\e[34m"
B_GREEN="\e[42m"

echo -e "${BOLD}${BLUE}Looking for CPU information...$RESET"

# Ex. 1 
echo "Processor model: $(grep -m 1 "model name" /proc/cpuinfo | awk -F ':' '{sub(" ", "", $2); print $2}')"

# Ex. 2
echo "Number of cores + threads: $(grep "model name" /proc/cpuinfo | wc -l)"

echo " "
echo -e "${BOLD}${BLUE}Getting heroes' names...$RESET"

# Ex. 3
curl $HEROES_CSV -o heroes.csv && awk -F ';' '{gsub(" ", "", $1); print tolower($1)}' heroes.csv > modified_heroes.csv

echo -e "${BOLD}${B_GREEN}Heroes' names saved on $(pwd)/modified_heroes.csv$RESET"
echo " "
echo -e "${BOLD}${BLUE}Obtaining the day of highest and lowest temperature...$RESET"

# Ex. 4
cat weather_cordoba.in | sort -k5 -n -r -t ' ' | head -n 1 | awk -F ' ' '{printf("%i-%i-%i: %.1fªC\n", $1, $2, $3, $5 / 10)}'; cat weather_cordoba.in | sort -k6 -n -t ' ' | head -n 1 | awk -F ' ' '{printf("%i-%i-%i: %.1fªC\n", $1, $2, $3, $6 / 10)}'

echo " "
echo -e "${BOLD}${BLUE}Ordering ATP players by their ranking...$RESET"

# Ex. 5
cat atpplayers.in | sort -k3 -n -t ' ' > modified_atpplayers.in

echo -e "${BOLD}${B_GREEN}Ranking-ordered ATP players were saved on $(pwd)/modified_atpplayers.in$RESET"
echo " "
echo -e "${BOLD}${BLUE}Ordering Superliga's teams...$RESET"

# Ex. 6
awk -F ' ' '{print $0, $7-$8}' superliga.in | sort -k2 -k9 -n -r -t ' ' > modified_superliga.in

echo -e "${BOLD}${B_GREEN}Superliga's teams ordered were saved on $(pwd)/modified_superliga.in$RESET"
echo " "
echo -e "${BOLD}${BLUE}Showing this computer's MAC Address...$RESET"

# Ex. 7
ip address | grep "link/ether" -m 1 | awk -F ' ' '{print $2}'

echo " "
echo -e "${BOLD}${BLUE}Creating and renaming subtitle files...$RESET"

# Ex. 8
if [ -d $SUBTITLES_FOLDER ]; then rm -rf $SUBTITLES_FOLDER; fi; mkdir $SUBTITLES_FOLDER && for i in {1..10}; do touch $SUBTITLES_FOLDER/$(tr -dc A-Za-z0-9 </dev/urandom | head -c 10)_${i}_es.srt; done; for f in $(find $SUBTITLES_FOLDER -name '*_es.srt'); do mv $f $(echo $f | awk -F '_es' '{print $1}').srt; done;

echo -e "${BOLD}${B_GREEN}Subtitle files created and renamed successfully at $(pwd)/${SUBTITLES_FOLDER}${RESET}"
echo " "
echo -e "${BOLD}${BLUE}Trimming sample video with ffmpeg...$RESET"

# Ex. 9
ffmpeg -i $(pwd)/test-video.mp4 -ss 00:00:02 -to 00:00:03 -c:v libx264 -c:a copy -b:v 2100k -pix_fmt yuv420p -y -loglevel error test-output.mp4

echo -e "${BOLD}${B_GREEN}Video trimming process completed! Saved to $(pwd)/test-output.mp4$RESET"
echo " "
echo -e "${BOLD}${BLUE}Merging two audio tracks with ffmpeg...$RESET"

# Ex. 9b
ffmpeg -i $(pwd)/test-audio-1.opus -i $(pwd)/test-audio-2.opus -filter_complex '[0:a]volume=0.2[a0];[1:a]volume=1.0[a1];[a1][a0]amerge=inputs=2,pan=stereo|FL<c0+c2|FR<c1+c3[a]' -map '[a]' -y -loglevel error test-output.opus

echo -e "${BOLD}${B_GREEN}Audio merging process completed! Saved to $(pwd)/test-output.opus$RESET"
