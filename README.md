# datastore-solr-configs

## Manual 

### Create or Update a configset in Solr

zip all configs
```bash
./zipConfigs.zsh
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
