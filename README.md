# datastore-solr-configs

## Manual - Create or Update a configset in Solr

```bash
(cd configsets/<configsetname>/conf && zip -r - *) > <configsetname>.zip

curl -X PUT --header "Content-Type:application/octet-stream" --data-binary @<configsetname>.zip
    "http://localhost:8983/api/cluster/configs/<configsetname>"
```