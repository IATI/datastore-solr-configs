# datastore-solr-configs

git clone <url> --recurse-submodules

https://git-scm.com/book/en/v2/Git-Tools-Submodules

## Convert Schema to Solrconfig / Make updates to a Config

Edit templates if necessary:

- Solr Schema - `schema-converter/templates/{collection}/managed-schema-template.xml`
- Solr Config - `schema-converter/templates/{collection}/solrconfig-template.xml`

Run schema converter:

```bash
cd schema-converter
./convertSchema.sh
```

This will make updates to:

- `configsets/{collection}/conf/managed-schema`
  - Replacing: `#COLLECTIONNAME#`, `#INSERTSCHEMA#`
- `configsets/{collection}/conf/solrconfig.xml`
  - Replacing: `#SEARCHDEFAULTS#`

Diff updates, commit to git

## Sync Configset to Solr

### Versioning

If the change requires a Re-Index, increment the version by 1. (e.g. {collection}_configset_8 to {collection}_configset_9)

If the change does not require a Re-Index and you would like to load into the existing Configset Used by your active collections, add a -N to the version. (e.g. {collection}_configset_8-1, {collection}_configset_8-2)

### Create or Update a configset in Solr

zip all configs

```bash
cd zips
./zipConfigs.zsh
# provide version number when prompted
```

zip a single config

```bash
(cd configsets/activity/conf && zip -r - *) > activity_configset_V.zip
```

If the change requires [reindexing](https://solr.apache.org/guide/8_10/reindexing.html), please follow our guide on the [wiki](https://github.com/IATI/IATI-Internal-Wiki/blob/main/IATI-Unified-Infra/Solr.md). You will need to create new configsets in Solr

```bash
curl -X PUT --header "Content-Type:application/octet-stream" --data-binary @<configsetname>.zip
    "<solrHost>/api/cluster/configs/<configsetname>"
```

If the change does not require reindexing, make sure to update the config used by the active Collection (with the correct `configsetname`).

Then RELOAD the Collection

```bash
curl --location --request GET '<solrHost>/api/solr/admin/collections?action=RELOAD&name=<collectionName>'
```
