# tapas-xq API

## Derive all production files from TEI document

`curl -F "requests=@REQ" -F "files=@DOC" http://localhost:8868/exist/apps/tapas-xq/derive-all`

Method: POST

Content-type: multipart/*

Requires:
* an XML-encoded list (see example below) of IDs and app-level metadata associated with each file in
* a ZIP-compressed package of TEI documents.

Returns: a ZIP-compressed package containing the requested production files. Each original TEI document will result in
* a MODS record and
* some number N of HTML files for use in the reading interface.

### XML elements in the list of production requests
<table>
  <tr>
    <td>NAME</td>
    <td>TYPE OF CONTENT</td>
    <td>DESCRIPTION</td>
  </tr>
  <tr>
    <td>requests</td>
    <td>node-set</td>
    <td>The root element. Wrapper around 1+ &lt;request&gt; elements and project-level information.</td>
  </tr>
  <tr>
    <td>proj-id</td>
    <td>string</td>
    <td>Identifier for the project that owns the XML document.</td>
  </tr>
  <tr>
    <td>request</td>
    <td>node-set</td>
    <td>Contains information specific to a given TEI file.</td>
  </tr>
  <tr>
    <td>filename</td>
    <td>string</td>
    <td>A reference to the original TEI document, as named in the attached ZIP package.</td>
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

requests := request+

request := filename doc-id proj-id is-public? collections file

filename := string

doc-id := STRING

proj-id := STRING

is-public := BOOLEAN

collections := collection*

collection := STRING

### Example batch-XML request

    <requests>
      <proj-id>gutenberg</proj-id>
      
      <request>
        <filename>ayer_sourcebook_tiny.xml</filename>
        <doc-id>sourcebook</doc-id>
        <is-public>true</is-public>
        <collections>
          <collection>churches</collection>
          <collection>history</collection>
        </collections>
      </request>
      
      <request>
        <filename>ayer_sourcebook.xml</filename>
        <doc-id>sourcebook2</doc-id>
        <is-public>true</is-public>
        <collections>
          <collection>churches</collection>
          <collection>history</collection>
        </collections>
      </request>
    </requests>
