# datastore-solr-configs

This repo contains the [Solr Configsets](https://solr.apache.org/guide/solr/latest/configuration-guide/config-sets.html) for the IATI Datastore

## Getting started

git clone <url> --recurse-submodules

https://git-scm.com/book/en/v2/Git-Tools-Submodules

## Convert Schema to Solrconfig / Make updates to a Config

Make a branch

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

Then zip all configs

```bash
cd zips
./zipConfigs.sh
# provide version number when prompted - see Versioning info below to decide how to version
```

Diff updates, commit to branch, make a PR, test, then merge.

## Sync Configset to Solr

The below details are all Solr implementation specific, which is why we link to the IATI internal wiki for some steps.

### Versioning

If the change requires a Re-Index, increment the version by 1. (e.g. {collection}_configset_8 to {collection}_configset_9)

If the change does not require a Re-Index and you would like to load into the existing Configset Used by your active collections, add a -N to the version. (e.g. {collection}_configset_8-1, {collection}_configset_8-2)

Only bump a version if there are changes to the configset. So the version numbers for each collection will not be totally the same.

See this guide to determine if you need a ReIndex with the change: https://solr.apache.org/guide/solr/latest/indexing-guide/reindexing.html#changes-that-require-reindex

### Create or Update a configset in Solr

Use zips from above, or zip a single config for testing

```bash
(cd configsets/activity/conf && zip -r - *) > activity_configset_V.zip
```

#### ReIndexing Required

If the change requires [reindexing](https://solr.apache.org/guide/solr/latest/indexing-guide/reindexing.html), please follow the guide on the [wiki](https://github.com/IATI/IATI-Internal-Wiki/blob/main/IATI-Unified-Infra/Solr.md).


#### No ReIndexing - In Place swap

If the change does not require reindexing, follow the guide on the [wiki](https://github.com/IATI/IATI-Internal-Wiki/blob/main/IATI-Unified-Infra/Solr.md#updating-solr-config-in-place-no-re-indexing-required) for that process
