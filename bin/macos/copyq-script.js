let result = [];
let file = null;
let item = null;
let filePath = '';
let text = '';
let formats = {
   'image/svg': 'svg',
   'image/png': 'png',
   'image/jpeg': 'jpg',
   'image/jpg': 'jpg',
   'image/bmp': 'bmp',
   'text/html': 'html',
   'text/plain' : 'txt',
}
for (let i = 0; i < size(); ++i) {
  item = getItem(i);
  for (let format in item) {
    if (format == 'image/png') {
      filePath = '/tmp/copyq-image-' + i + '.' + formats[format]
      file = new File(filePath);
      file.openWriteOnly();
      file.write(item[format]);
    }
  }
  //text = str(read(i));
  text = str(read(i)).replace(/\n/g, '\\n');

  result.push({
    row: i,
    text: text != '' ? text : filePath,
    type: text != '' ? 'text' : 'image'
  })
    //var obj = {};
    //obj.row = i;
    //obj.text = getItem(i);
    //result.push(obj);
}
JSON.stringify(result);
