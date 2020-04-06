({
    tableData : function(component,responseValue) {

        /* 
         for remove title , table head and ID field 
         from receive data.
        */
        var returnTableData = [];
        var i,j;
        var length = responseValue[2].length;
        var rowLength = responseValue.length - 2;
        var recordIDList = [];
        for(i = 0;i< rowLength ;i++){
            var singleRowData = [];
            recordIDList.push(responseValue[i+2][0]);
            for(j = 1 ;j < length ; j++){
                singleRowData[j-1] = responseValue[i+2][j];
            }
            returnTableData.push(singleRowData);
        }
        console.log('Helper -->  Before set ID component');
        component.set('v.recordIDList',recordIDList);
        console.log('Helper --> ',returnTableData);
        return returnTableData;
    },
    showTableData: function (component, responseValue) {
        console.log('Helper --> ','showTableData');
        var tableTitleJS = component.get('v.tableTitle');
        var tableHeadItems = component.get('v.tableHead');
        var tableDataJs = component.get('v.tableData');
        tableTitleJS = responseValue[0][0];
        component.set('v.tableTitle', tableTitleJS);
        tableHeadItems = responseValue[1];
        component.set('v.tableHead', tableHeadItems);
        tableDataJs = this.tableData(component,responseValue);
        component.set('v.tableData', tableDataJs);
        component.set('v.emptyTableData','');
    },
    showEmptyTableData: function (component, responseValue) {
        console.log('Helper --> ','showEmptyTableData');
        var tableTitleJS = component.get('v.tableTitle');
        var tableHeadItems = [];
        var tableDataJs = [];
        tableTitleJS = responseValue[0][0];
        component.set('v.tableTitle', tableTitleJS);
        component.set('v.tableHead', tableHeadItems);
        component.set('v.tableData', tableDataJs);
        component.set('v.emptyTableData',responseValue[1][0]);
    }
})
