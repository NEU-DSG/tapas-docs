# tapas-xq API

## For all requests

### Authentication

Each request must contain _either_

* an eXist-db user name and password with the permissions to execute XQueries and modify the 'tapas-data' collection, _or_
* an Authentication header with a user token implying the above.

### Status codes

Success: 200
Log-in failed/insufficient permissions for executing request: 401
Unsupported HTTP method: 405
Unable to access some resource: 500

## Resource requests

### Derive MODS production file from a TEI document

`POST exist/apps/tapas-xq/derive-mods`

Content-type: application/x-www-form-urlencoded

Request body must be a TEI-encoded XML document.

Returns an XML-encoded file of the MODS record with status code 200. eXist does not store any files as a result of this request.

### Derive XHTML (reading interface) production files from a TEI document

`POST exist/db/apps/tapas-xq/derive-reader/:type`

Content-type: multipart/form-data

__`:type`__: A keyword representing the type of reader view to generate. Values can be "teibp" or "tapas-generic".

Parameters:
| assets-base | A file path representing the parent folder of any CSS/JS/image assets that will be referenced by the resulting HTML document. |
| file | An XML-encoded TEI document. |

Returns XHTML generated from the TEI document with status code 200. eXist does not store any files as a result of this request.

## Storage requests

__`:doc-id`__: A unique identifier for the document record attached to the original TEI document and its derivatives (MODS, TFE). Currently maps to the Drupal identifier ('did').

### Store TEI in eXist

`PUT exist/db/apps/tapas-xq/:doc-id/tei`

Request body must be a TEI-encoded XML document.

### Store MODS metadata in eXist (and return the new XML file)

`POST exist/db/apps/tapas-xq/:doc-id/metadata`

Content-type: multipart/form-data

Parameters:
| title | The work's title. |
| languages |  | <!-- ? -->
| extent |  | <!-- ? -->
| abstract |  |
| access-condition |  |
| personal-names + roles |  | <!-- Dealing with this is thorny. Do we want to encourage a "LAST, FIRST" policy? How will this be represented in the form data? -->
| org-name |  |
| pub-place |  |
| publishers |  |
| date-created |  |
| edition |  |
| notes |  |

_We should be clear which metadata we want to allow the user to edit. I suspect we want to focus our efforts on the fields specific to the TEI file and its encoding (above), rather than any source material (below)._
| subj-topics |  |
| series-title |  |
| series-editor |  |
| orig-title |  |
| monogr-title |  |
| monogr-author |  |
| imprint-place |  |
| imprint-publisher |  |
| imprint-date |  |

If no TEI document is associated with the given doc-id, the response will have a status code of 500. The TEI file must be stored _before_ any of its derivatives.

### Store TFE metadata in eXist

`POST exist/db/apps/tapas-xq/:doc-id/tfe`

Content-type: multipart/form-data

Parameters:
| proj-id | The identifier of the project which owns the work. |
| collections | Comma-separated list of collection identifiers with which the work should be associated. |
| is-public | Value of "true" or "false". Indicates if the XML document should be queryable by the public. Default value is false. (Note that if the document belongs to even one public collection, it should be queryable.) |
| transforms | Comma-separated list of reader interface transformations compatible with this document. | <!-- ? -->

If no TEI document is associated with the given doc-id, the response will have a status code of 500. The TEI file must be stored _before_ any of its derivatives.

### Delete document and derivatives

`DELETE exist/db/apps/tapas-xq/:doc-id`

If no TEI document is associated with the given doc-id, the response will have a status code of 500.

## Maintenance requests

### Trigger file reindexing (manually)

`POST exist/db/apps/tapas-xq/reindex`

