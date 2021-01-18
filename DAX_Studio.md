# DAX STUDIO

## Use case:
* Export data (for data more than 1 million rows)
* Role and RLS testing 
* Get list of measures (below)
* Get list of columns (below)
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
	   [Type],  --between brackets as type is a reserved keyword
	   isHidden,
	   inferredDataType,
	   explicitDataType
  FROM $System.TMSCHEMA_COLUMNS
 WHERE NOT isHidden 
   AND ( [Type] = 1 or [Type] = 2) --columns or calculated columns
 ORDER BY tableid
```

