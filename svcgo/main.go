package main

import (
  "github.com/gofiber/fiber/v2"
  "errors"
  "encoding/json"
  "net/http"
  "fmt"
  "bytes"
)

type DataSet struct {
  Id int `json:"id"`
  Name string `json:"name,omitempty"`
  RandomIdentifier string `json:"ri,omitempty"`
  RandomIdentifier2 string `json:"ri2,omitempty"`
  CID int `json:"cid,omitempty"`
  EID int `json:"eid,omitempty"`
  PrevDataID int `json:"prev_data_id,omitempty"`
}

type TestData struct {
  Id int `json:"id"`
  Name string `json:"name,omitempty"`
  UserId int `json:"user,omitempty"`
}

type AccDataSet struct {
  Id int `json:"id"`
  RIdentifier string `json:"ri,omitempty"`
  RIdentifier2 string `json:"ri2,omitempty"`
  DataDesc string `json:data_desc`
  CID int `json:"cid,omitempty"`
  EID int `json:"eid,omitempty"`
  PrevDataID int `json:"prev_data_id,omitempty"`
}


func makeRequest1(data *DataSet) (string, error) {
  cli:= http.Client{}
  commands := []string{  "cmd1", "cmd2", "cmd3" }
  var j map[string]interface{}
  for idx, cmd:= range commands {
    j[fmt.Sprintf("v%d",idx)] = interface{}(cmd)
  }
  buf:= bytes.NewBuffer([]byte(data.Name))
  req, err := http.NewRequest("GET", "http://localhost:3030/data", buf)
  req.Header.Add("Content-Type", "application/json")
  if err != nil {
    _, err = cli.Do(req)
  } else {
    return "", err
  }
  return "",nil
}

func getData(ctx* fiber.Ctx) error {
  data := TestData{}
  if len(ctx.Body()) == 0 {
    ctx.Response().SetStatusCode(500)
    ctx.Response().SetBodyString(`{"error" : "no data"}`)
    return errors.New("invalid request")
  }
  err := json.Unmarshal(ctx.Body(), &data)
  if err == nil {
    if data.Name == "key1" {
      ctx.Response().SetStatusCode(200)
      ctx.Response().SetBodyString(fmt.Sprintf(`{"value" : "value_%d"}`, data.UserId))
    }
  }
  return nil
}

func getAccData(ctx* fiber.Ctx) error {
  data := AccDataSet{}
  if len(ctx.Body()) == 0 {
    ctx.Response().SetStatusCode(500)
    ctx.Response().SetBodyString(`{"error" : "no data"}`)
    return errors.New("invalid request")
  }
  err := json.Unmarshal(ctx.Body(), &data)
  if err == nil {
    if data.CID == 31 {
      for i:=0; i < data.EID; i++ {
        makeAccRequest(&data)
      }
      ctx.Response().SetStatusCode(200)
      ctx.Response().SetBodyString(fmt.Sprintf(`{"status" : "ok"}`))
    }
  }
  return nil
}

func makeAccRequest(data *AccDataSet) (string, error) {
  cli:= http.Client{}
  commands := []string{  "cid", "eid", "did" }
  var j map[string]interface{}
  for idx, cmd:= range commands {
    j[fmt.Sprintf("v%d",idx)] = interface{}(cmd)
  }
  buf:= bytes.NewBuffer([]byte(data.DataDesc))
  req, err := http.NewRequest("GET", "http://localhost:3030/accdata", buf)
  req.Header.Add("Content-Type", "application/json")
  if err != nil {
    _, err = cli.Do(req)
  } else {
    return "", err
  }
  return "",nil
}

func main() {
  conn := fiber.New(fiber.Config{})
  conn.Get("/align", getAccData)
  conn.Post("/data", getData)
  conn.Get("/acc/:id", getAccData)
  conn.Get("/acc/:id/cid", getAccData)
  conn.Get("/acc/:id/cid/:cid/eid", getAccData)
  conn.Listen(":8888")
}
