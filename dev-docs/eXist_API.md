# tapas-xq API

## Derive all production files from a TEI document

`curl -F "request=@REQ" -F "file=@DOC" http://localhost:8868/exist/apps/tapas-xq/derive-all`

Method: POST

Content-type: multipart/*

Requires:
* an XML-encoded list (see example below) of IDs and app-level metadata associated with
* an XML-encoded TEI document.

Returns: 
* a ZIP-compressed package containing the requested production files. Each original TEI document will result in:
  * mods.xml
  * _teibp_
    * FILENAME.xhtml
  * _tapas_generic_
    * FILENAME.xhtml

Stores:
* a copy of the original TEI file,
* the new MODS file, and 
* a new XML file containing document-level permissions.

### XML elements in the list of production requests
<table>
  <tr>
    <td>NAME</td>
    <td>TYPE OF CONTENT</td>
    <td>DESCRIPTION</td>
  </tr>
  <tr>
    <td>request</td>
    <td>node-set</td>
    <td>Contains information specific to a given TEI file.</td>
  </tr>
  <tr>
    <td>proj-id</td>
    <td>string</td>
    <td>Identifier for the project that owns the XML document.</td>
  </tr>
  <tr>
    <td>doc-id</td>
    <td>string</td>
    <td>Identifier for the XML document.</td>
  </tr>
  <tr>
    <td>is-public</td>
    <td>boolean</td>
    <td>Value of "true" or "false". Indicates if the XML document
      should be queryable by the public. Default value is false. (Note 
      that if the document belongs to even one public collection, it
      should be queryable.)</td>
  </tr>
  <tr>
    <td>collections</td>
    <td>collection*</td>
    <td>Container for 0 or more collection identifiers.</td>
  </tr>
  <tr>
    <td>collection</td>
    <td>string</td>
    <td>Identifier for a collection belonging to the owner project. 
      The XML document will be associated with this collection.</td>
  </tr>
</table>

### Grammar

request := doc-id proj-id is-public? collections file

doc-id := STRING

proj-id := STRING

is-public := BOOLEAN

collections := collection*

collection := STRING

### Example XML request

    <request>
      <doc-id>sourcebook</doc-id>
      <proj-id>gutenberg</proj-id>
      <is-public>true</is-public>
      <collections>
        <collection>churches</collection>
        <collection>history</collection>
      </collections>
    </request>
