#!/bin/bash
# by: ZnHoCn
# crontab:
# 0 * * * * bash /<PATH>/slog/slog.sh 2&> /dev/null

data_file="data.txt"
date_file="date_$(date +%Y).log"

cd $(cd `dirname $0`; pwd)
git pull

touch $data_file
cat /dev/urandom | base64 | head -c 1000 > $data_file
touch $date_file
echo "$(date +%F\ %H\:%M) is OK" >> $date_file

git add .
git commit -am "Updated: $(date +%F\ %H\:%M)"
#git push
if [ -z $(git push  2>&1 | grep fatal) ]; then
    echo "git push fatal"
    rm -rf $(cd `dirname $0`; pwd)
    git clone git@github.com:test/slog.git
else
    echo "git push ok"
fi
