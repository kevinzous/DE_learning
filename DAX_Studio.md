Learning ressources for Data Warehousing - BI - Data Analytics 
# DAX STUDIO

## Use case:
* Export data (for data more than 1 million rows)
* Role and RLS testing 
* and more https://exceleratorbi.com.au/getting-started-dax-studio/

## Useful links
* Documenting your Tabular or Power BI Model https://datasavvy.me/2016/10/04/documenting-your-tabular-or-power-bi-model/ 
* https://www.biinsight.com/dax-measure-dependencies-in-ssas-tabular-and-power-bi/ 
## Get list of measures
 ```sql
SELECT measuregroup_name AS table_name, 
   	   measure_name, 
   	   expression
  FROM $System.MDSCHEMA_MEASURES
 WHERE measure_aggregator = 0
 ORDER BY measuregroup_name
```

## Get list of columns
 ```sql
SELECT tableid,
	   explicitName,
	   expression,
	   formatString, 
	   [Type],
	   isHidden,
	   inferredDataType,
	   explicitDataType
  FROM $System.TMSCHEMA_COLUMNS
 WHERE NOT isHidden 
   AND ( [Type] = 1 or [Type] = 2) --columns or calculated columns
 ORDER BY tableid

```

 ```sql
SELECT [CATALOG_NAME] as [DATABASE],
    CUBE_NAME AS [CUBE],[MEASUREGROUP_NAME] AS [FOLDER],[MEASURE_CAPTION] AS [MEASURE],
    [MEASURE_IS_VISIBLE]
FROM $System.MDSCHEMA_MEASURES
```


 ```sql
select * from $SYSTEM.DBSCHEMA_COLUMNS
where column_olap_type='ATTRIBUTE'
```

 ```sql
select * from $SYSTEM.TMSCHEMA_TABLES
WHERE not ishidden 
```