$().ready(function() {
	// Vertical splitter. Set min/max/starting sizes for the left pane.
	$("#MySplitter").splitter({
		splitVertical: true,
		outline: true,
		sizeLeft: 150,
		resizeTo: window,
		accessKey: "I"
	});

	// $("#LeftPane").splitter({
	// 	splitHorizontal: true,
	// 	sizeTop: 100,
	// 	accessKey: "H"
	// });

	// Horizontal splitter, nested in the right pane of the vertical splitter.
	$("#RightPane").splitter({
		splitHorizontal: true,
		sizeTop: true,
		accessKey: "H"
	});

});
