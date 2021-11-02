#!/bin/bash
# zip up all the configsets to prepare them to be POST'd to solr
for COLPATH in configsets/* ; do
    echo "zipping: "$COLPATH
    COLLECTION=$(basename "$COLPATH")
    read -p 'Configset version number: ' NUM
    FILENAME="${COLLECTION}_configset_${NUM}.zip"
    (cd $COLPATH/conf && zip -r - *) > $FILENAME 
done