const express = require("express");
const request = require("request");
const app = express();
const $ = require("cheerio");
const rp = require("request-promise");
const jsdom = require("jsdom");
const { JSDOM } = jsdom;
const port = process.env.PORT || 3000;
const apiKey = "ZxiWudzdDanY5tIge7tIar6S9RCvhv89zSuxSEz6";

app.get("/", async function(req, res) {
  var upc = req.query.upc;
  var ndbno = await getNDB(upc);
  if (ndbno.errors) {
    var title = await getNDBBackup1(upc);
    if (title == "no") {
      res.json({
        error: "Couldn't find item"
      });
    } else {
      ndbno = await getNDBBackup2(title);
    }
  }
  console.log("NDBno: " + ndbno);
  if (ndbno && !ndbno.errors) {
    var data = await getData(ndbno);
    res.json(data);
  } else {
    res.json({
      error: "Couldn't find item"
    });
  }
});

app.get("/weather", function(req, res) {
  var id = req.query.id.toLowerCase();
  if (id.length > 0) {
    var url = (url = "https://weather.com/forecast/allergy/l/" + id);

    rp(url)
      .then(function(html) {
        //success!
        var JSONString2 = [];
        var num = 0;
        var updated = $("circle", html).each(function() {
          if (
            (!(typeof $(this).attr("style") === "undefined") ||
              $(this).attr("style") != null) &&
            num < 3
          ) {
            num += 1;
            // console.log();
            //  console.log($(this).css('stroke-dashoffset'));
            var big = parseFloat($(this).css("stroke-dasharray"), 10);
            var small = parseFloat($(this).css("stroke-dashoffset"), 10);
            var divided = 1 - small / big;
            JSONString2.push(divided);
          }
        });

        var updated = $(".col.humidity", html)
          .html()
          .toString();
        var humidity = parseFloat(
          updated.substring(
            updated.indexOf("<div>") + 5,
            updated.indexOf("<sup>")
          )
        );

        JSONString2.push(humidity);
        var updatedd = $(".results__value", html)
          .html()
          .toString();
        var humidityy = parseFloat(
          updatedd.substring(
            updatedd.indexOf("<sup>") - 3,
            updatedd.indexOf("<sup>")
          )
        );
        //console.log(updatedd);
        JSONString2.push(humidityy);
        var updateddd = $(".col.outdoor", html)
          .html()
          .toString();
        var humidityyy = parseFloat(
          updateddd.substring(
            updateddd.indexOf("<div>") + 5,
            updateddd.indexOf("<!---->")
          )
        );
        //console.log(updateddd);
        JSONString2.push(humidityyy);
        res.send(JSONString2);
      })
      .catch(function(err) {
        console.log(err);
        res.send(err);
      });
  } else {
    res.send("error");
  }
});

function getNDB(upc) {
  return new Promise((resolve, reject) => {
    const url = `https://api.nal.usda.gov/ndb/search/?format=json&q=UPC:${upc}&max=1&api_key=${apiKey}`;
    request(url, (e, r, b) => {
      var jsonString = JSON.parse(b);
      if (!e && !jsonString.errors) {
        resolve(jsonString.list.item[0].ndbno);
      } else {
        resolve(jsonString);
      }
    });
  });
}
function getNDBBackup1(upc) {
  return new Promise((resolve, reject) => {
    const url = `https://www.barcodelookup.com/${upc}`;
    request(url, (e, r, b) => {
      if (r.statusCode == 200) {
        var html = new JSDOM(b);
        if (html.window.document.getElementsByTagName("h4")[0]) {
          resolve(
            html.window.document.getElementsByTagName("h4")[0].textContent
          );
        } else {
          resolve("no");
        }
      }
    });
  });
}
function getNDBBackup2(upc) {
  return new Promise((resolve, reject) => {
    const url = `https://api.nal.usda.gov/ndb/search/?format=json&q=${encodeURIComponent(
      upc
    )}&max=1&api_key=${apiKey}`;
    request(url, (e, r, b) => {
      var jsonString = JSON.parse(b);
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
function getDataBackup(ndbno) {
  return new Promise((resolve, reject) => {
    const url = `https://api.nal.usda.gov/ndb/V2/reports?ndbno=${ndbno}&type=f&format=json&api_key=${apiKey}`;
    request(url, (e, r, b) => {
      if (!e) {
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
