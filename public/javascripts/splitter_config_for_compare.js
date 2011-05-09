$(document).ready(
  function() {
    $("#splitterContainer").splitter(
      { splitVertical:true,
        A:$('#leftPane'),
        B:$('#rightPane'),
        closeableto:50 });
  }
);
