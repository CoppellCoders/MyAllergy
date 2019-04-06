const express = require("express");
const request = require("request");
const app = express();
const port = process.env.PORT || 3000;
const apiKey = "ZxiWudzdDanY5tIge7tIar6S9RCvhv89zSuxSEz6";

app.get("/", async function(req, res) {
  var upc = req.query.upc;
  var ndbno = await getNDB(upc);
  if (ndbno.errors) {
    res.json(ndbno);
  } else {
    console.log(ndbno);
    var data = await getData(ndbno);
    res.json(data);
  }
});

function getNDB(upc) {
  return new Promise((resolve, reject) => {
    const url = `https://api.nal.usda.gov/ndb/search/?format=json&q=UPC:${upc}&max=1&api_key=${apiKey}`;
    request(url, (e, r, b) => {
      var jsonString = JSON.parse(b);
      console.log(b);
      if (!e && !jsonString.errors) {
        resolve(jsonString.list.item[0].ndbno);
      } else {
        resolve(jsonString);
      }
    });
  });
}

function getData(ndbno) {
  return new Promise((resolve, reject) => {
    const url = `https://api.nal.usda.gov/ndb/V2/reports?ndbno=${ndbno}&type=f&format=json&api_key=${apiKey}`;
    request(url, (e, r, b) => {
      if (!e) {
        console.log(b);
        var jsonString = JSON.parse(b);
        var foodName = jsonString.foods[0].food.desc.name;
        var commercialName = jsonString.foods[0].food.desc.cn;
        var manufacturer = jsonString.foods[0].food.desc.manu;
        var ingredients = jsonString.foods[0].food.ing.desc;
        var data = {
          name: foodName,
          cn: commercialName,
          manu: manufacturer,
          ing: ingredients
        };
        resolve(data);
      } else {
        console.log(e);
      }
    });
  });
}

app.listen(port, () => console.log(`Example app listening on port ${port}!`));
