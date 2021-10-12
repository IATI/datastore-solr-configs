# datastore-solr-configs

## Manual 

### Create or Update a configset in Solr

```bash
(cd configsets/<configsetname>/conf && zip -r - *) > <configsetname>.zip

curl -X PUT --header "Content-Type:application/octet-stream" --data-binary @<configsetname>.zip
    "http://localhost:8983/api/cluster/configs/<configsetname>"
```

### RELOAD Collection

This apply's any updates to the configset to the live collection

```
GET {{baseURL}}/solr/admin/collections?action=RELOAD&name=<collection_name>
```

### Create a Collection from a configset

```
GET {{baseURL}}/solr/admin/collections?action=CREATE&name=<collection_name>&numShards=1&collection.configName=<configset_name>&replicationFactor=3
```