#!/bin/bash
# zip up all the configsets to prepare them to be POST'd to solr
for COLPATH in configsets/* ; do
    echo "zipping: "$COLPATH
    COLLECTION=$(basename "$COLPATH")
    echo $COLLECTION
    DATE=$(date "+%F")
    FILENAME="${COLLECTION}configset_${DATE}.zip"
    echo $FILENAME
    (cd $COLPATH/conf && zip -r - *) > $FILENAME 
done