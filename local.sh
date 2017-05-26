echo "Downloading AdBlock Lists (EasyList, EasyPrivacy, Fanboy Annoyance / Social Blocking / Easylist Germany / Ultimate Fanboy List / Adblock Plus 'Blockzilla' )..."
curl -s -L https://easylist.to/easylist/easylist.txt https://easylist.to/easylist/easyprivacy.txt https://easylist.to/easylist/fanboy-annoyance.txt https://easylist.to/easylist/fanboy-social.txt https://easylist-downloads.adblockplus.org/easylistgermany+easylist.txt http://fanboy.co.nz/r/fanboy-ultimate.txt https://raw.githubusercontent.com/zpacman/Blockzilla/master/Blockzilla.txt > adblock.unsorted

echo "Looking for: ||domain.tld^..."
sort -u adblock.unsorted | grep ^\|\|.*\^$ | grep -v \/ > adblock.sorted

echo "Remove extra chars and put list under lighttpd web root..."
sed 's/[\|^]//g' < adblock.sorted > /var/www/html/adblock.hosts

echo "Remove files we no longer need..."
rm adblock.unsorted adblock.sorted

echo "Updating Lists..."
pihole -g
