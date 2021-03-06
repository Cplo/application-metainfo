{
    "aliases" : { },
    "mappings" : {
      "config" : {
        "properties" : {
          "buildNum" : {
            "type" : "keyword"
          },
          "defaultIndex" : {
            "type" : "text",
            "fields" : {
              "keyword" : {
                "type" : "keyword",
                "ignore_above" : 256
              }
            }
          },
          "timelion:showTutorial" : {
            "type" : "boolean"
          }
        }
      },
      "search" : {
        "properties" : {
          "columns" : {
            "type" : "text"
          },
          "description" : {
            "type" : "text"
          },
          "hits" : {
            "type" : "integer"
          },
          "kibanaSavedObjectMeta" : {
            "properties" : {
              "searchSourceJSON" : {
                "type" : "text"
              }
            }
          },
          "sort" : {
            "type" : "text"
          },
          "title" : {
            "type" : "text"
          },
          "version" : {
            "type" : "integer"
          }
        }
      },
      "server" : {
        "properties" : {
          "uuid" : {
            "type" : "keyword"
          }
        }
      },
      "dashboard" : {
        "properties" : {
          "description" : {
            "type" : "text"
          },
          "hits" : {
            "type" : "integer"
          },
          "kibanaSavedObjectMeta" : {
            "properties" : {
              "searchSourceJSON" : {
                "type" : "text"
              }
            }
          },
          "optionsJSON" : {
            "type" : "text"
          },
          "panelsJSON" : {
            "type" : "text"
          },
          "refreshInterval" : {
            "properties" : {
              "display" : {
                "type" : "text"
              },
              "pause" : {
                "type" : "boolean"
              },
              "section" : {
                "type" : "integer"
              },
              "value" : {
                "type" : "integer"
              }
            }
          },
          "timeFrom" : {
            "type" : "text"
          },
          "timeRestore" : {
            "type" : "boolean"
          },
          "timeTo" : {
            "type" : "text"
          },
          "title" : {
            "type" : "text"
          },
          "uiStateJSON" : {
            "type" : "text"
          },
          "version" : {
            "type" : "integer"
          }
        }
      },
      "index-pattern" : {
        "properties" : {
          "fieldFormatMap" : {
            "type" : "text"
          },
          "fields" : {
            "type" : "text"
          },
          "intervalName" : {
            "type" : "text"
          },
          "notExpandable" : {
            "type" : "boolean"
          },
          "sourceFilters" : {
            "type" : "text"
          },
          "timeFieldName" : {
            "type" : "text"
          },
          "title" : {
            "type" : "text"
          }
        }
      },
      "visualization" : {
        "properties" : {
          "description" : {
            "type" : "text"
          },
          "kibanaSavedObjectMeta" : {
            "properties" : {
              "searchSourceJSON" : {
                "type" : "text"
              }
            }
          },
          "savedSearchId" : {
            "type" : "text"
          },
          "title" : {
            "type" : "text"
          },
          "uiStateJSON" : {
            "type" : "text"
          },
          "version" : {
            "type" : "integer"
          },
          "visState" : {
            "type" : "text"
          }
        }
      },
      "timelion-sheet" : {
        "properties" : {
          "description" : {
            "type" : "text"
          },
          "hits" : {
            "type" : "integer"
          },
          "kibanaSavedObjectMeta" : {
            "properties" : {
              "searchSourceJSON" : {
                "type" : "text"
              }
            }
          },
          "timelion_chart_height" : {
            "type" : "integer"
          },
          "timelion_columns" : {
            "type" : "integer"
          },
          "timelion_interval" : {
            "type" : "text"
          },
          "timelion_other_interval" : {
            "type" : "text"
          },
          "timelion_rows" : {
            "type" : "integer"
          },
          "timelion_sheet" : {
            "type" : "text"
          },
          "title" : {
            "type" : "text"
          },
          "version" : {
            "type" : "integer"
          }
        }
      }
    },
    "settings" : {
      "index" : {
        "number_of_shards" : "1",
        "number_of_replicas" : "1"
      }
    }
}
