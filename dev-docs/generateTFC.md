# Derive production files from TEI document


### Parameters
<table>
  <tr>
    <td>NAME</td>
    <td>TYPE</td>
    <td>DESCRIPTION</td>
  </tr>
  <tr>
    <td>doc-id</td>
    <td>string</td>
    <td>Identifier for the XML document.</td>
  </tr>
  <tr>
    <td>user-id</td>
    <td>string</td>
    <td>Identifier for the uploader of the XML document.</td>
  </tr>
  <tr>
    <td>proj-id</td>
    <td>string</td>
    <td>Identifier for the project that owns the XML document.</td>
  </tr>
  <tr>
    <td>is-public</td>
    <td>boolean</td>
    <td>Value of "true" or "false". Indicates if the XML document
      should be queryable by the public. Default value is false.</td>
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
  <tr>
    <td>file</td>
    <td>node-set</td>
    <td>The XML content of the document.</td>
  </tr>
</table>

### Grammar

requests := request+

request := doc-id user-id proj-id is-public? collections file

doc-id := STRING

user-id := STRING

proj-id := STRING

is-public := BOOLEAN

collections := collection*

collection := STRING

file := NODE-SET

### Example

    <requests>
  
      <request>
        
        <doc-id>sourcebook</doc-id>
        
        <user-id>ayer</user-id>
        
        <proj-id>gutenberg</project-id>
        
        <is-public>true</is-public>
        
        <collections>
        
          <collection>churches</collection>
        
          <collection>history</collection>
        
        </collections>
        
        <file>
          
          <?xml version="1.0" encoding="utf-8" ?>
        
          <TEI xmlns="http://www.tei-c.org/ns/1.0" xml:lang="en"> ... </TEI>
        
        </file>
        
      </request>
      
    </requests>
