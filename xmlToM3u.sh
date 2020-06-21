#!/bin/bash
#####################################################################
##                                                                 ##
##             Script de convertion de playlist XML                ##
##            généré par Jellyfin vers un fichier M3U              ##
##                    pour les rendre publique                     ##
##         Pour utiliser :                                         ##    
##               Copier le dossier de la playlist                  ##
##         situé a /var/lib/jellyfin/data/playlists/ vers          ##
##     Votre dossier de musique copier ce script à l'intérieur     ##
##    du dossier de la playlist qui est dans le dossier musique    ##
##     ensuit double cliquer sur le script et le tour est joué !   ##
##                                                                 ##  
#####################################################################
                                                                   ##
##déterminer les paths et le nom du dossier parent au script       ##
fname='playlist.xml'                                               ##
                                                                   ##
##deteminer le path de la playlist XML                             ##
playlist=$(readlink -f "$fname")                                   ##
                                                                   ##
##String pour le format de sortit                                  ##
format=".m3u"                                                      ##
                                                                   ##
##déterminer le nom du dossier parent de la playlist               ##
parentname="$(basename "$(dirname "$playlist")")"                  ##
                                                                   ##
##Determiner le nom du fichier sortant                             ##
m3uPlaylist="$parentname$format"                                   ##
                                                                   ##
##creer le fichier m3u a partir du fichier xml                     ##  
cp "$playlist"  "$m3uPlaylist"                                     ##
                                                                   ##
##convertir la syntax en m3u                                       ##
sed -i 's/    <PlaylistItem>/#EXTINF:/g' "$m3uPlaylist"            ##
sed -i 's/      <Path>//g' "$m3uPlaylist"                          ##  
sed -i 's#</Path>##g' "$m3uPlaylist"                               ##
sed -i 's/  <PlaylistItems>/#EXTM3U/g' "$m3uPlaylist"              ##
sed -i 's#    </PlaylistItem>##g' "$m3uPlaylist"                   ##
                                                                   ##
##Ajoute un marqueur de fin                                        ##
sed -i 's\  </PlaylistItems>\###\g' "$m3uPlaylist"                 ##
                                                                   ##
##enlever le debut et la fin                                       ##
from1="#EXTM3U"                                                    ##  
to2="###"                                                          ##
a="$(cat "$m3uPlaylist")"                                          ##  
a="$(echo "${a#*"$from1"}")"                                       ##
echo "$from1${a%%"$to2"*}$to2" > ./"$m3uPlaylist"                  ##
                                                                   ##
##Enlever le marqueur de fin                                       ##
sed -i 's\###\\g' "$m3uPlaylist"                                   ##
                                                                   ##
#####################################################################
##                                                                 ##
##   Lebelou.ga 2020 Marc-André Legault                            ## 
##                                                                 ##
#####################################################################
