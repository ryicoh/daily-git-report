#!/bin/sh

if [[ -z $SLACK_HOOK_URL ]]; then
	echo "SLACK_HOOK_URL must not be empty"
	exit 1
fi

if [[ -z $REPOSITORY_NAME ]]; then
	echo "REPOSITORY_NAME must not be empty"
	exit 1
fi

if [[ -z $REPOSITORY_URL ]]; then
	echo "REPOSITORY_URL must not be empty"
	exit 1
fi

if [[ -z $AUTHOR ]]; then
	echo "AUTHOR must not be empty"
	exit 1
fi

git clone --depth=1 $REPOSITORY_URL
cd $REPOSITORY_NAME

COMMIT_LOG=$(git shortlog --all --no-merges --author="${AUTHOR}"  --since="1 day ago")
echo $COMMIT_LOG

LINES=$(git log --all --numstat --pretty="%H" --author="${AUTHOR}" --since="1 day ago" | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}')
echo $LINES

MESSAGE="${COMMIT_LOG} \\r\\n [insertions, deletions]: \\r\\n ${LINES}"
echo $MESSAGE

PAYLOAD="payload={\"channel\":\"${SLACK_CHANNEL}\" , \"text\":\"${MESSAGE}\"}"

curl -X POST --data-urlencode "${PAYLOAD}" ${SLACK_HOOK_URL}
