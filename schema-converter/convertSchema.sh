#!/bin/bash

if [ ! -d "IATIStandardSSOT" ]; then
    echo "$0: script must be run from the 'schema-converter' dir in datastore-solr-configs repo"
    exit 1
fi

git submodule update --init --recursive
git submodule update --remote

cd IATIStandardSSOT

if [ ! -d pyenv ]; then
  python3 -m venv pyenv
  source pyenv/bin/activate
  pip install -r requirements.txt
else
  source pyenv/bin/activate
fi

for COLPATH in ../../configsets/* ; do
    COLLECTION=$(basename "$COLPATH")
    echo "converting schema for: "$COLLECTION
    SOLRCONFIG_TEMPLATE="../templates/${COLLECTION}/solrconfig-template.xml"
    SOLRCONFIG_DEST="../../configsets/${COLLECTION}/conf/solrconfig.xml"
    SOLRSCHEMA_TEMPLATE="../templates/${COLLECTION}/managed-schema-template.xml"
    SOLRSCHEMA_DEST="../../configsets/${COLLECTION}/conf/managed-schema"
    python gen_solr.py $COLLECTION $SOLRCONFIG_TEMPLATE $SOLRCONFIG_DEST $SOLRSCHEMA_TEMPLATE $SOLRSCHEMA_DEST
done
