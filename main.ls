require! <[ fs xamel ]>

_, data <- fs.readFile "#__dirname/tmp/content.xml" \utf8
_, xml <- xamel.parse data
console.log JSON.stringify(walk(xml),,2).replace do
  /[\u007f-\uffff]/g -> "\\u#{ ("0000"+it.charCodeAt(0).toString(16)).slice -4 }"

function walk (it)
  return it.map(walk) if it instanceof Array
  it.name.=toUpperCase! if it.name
  it.attrs = {[key.toUpperCase!, val] for key, val of it.attrs} if it.attrs
  it.children.=map(walk) if it.children
  return it
