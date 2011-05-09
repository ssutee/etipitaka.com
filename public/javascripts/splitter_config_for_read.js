$(document).ready(
  function() {
    $("#splitterContainer").splitter(
      { minAsize:0,maxAsize:700,
        splitVertical:true,
        A:$('#leftPane'),
        B:$('#rightPane'),
        slave:$("#rightSplitterContainer"),
        closeableto:0
        });
    $("#rightSplitterContainer").splitter(
      { maxBsize:1,
        splitHorizontal:true,
        A:$('#rightTopPane'),
        B:$('#rightBottomPane'),
        closeableto:100 });
  }
);
