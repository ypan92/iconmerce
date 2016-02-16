function loadLogin() {
	console.log("here");
	//window.location.href = "./login.php";
	location.href = "./login.php";
}

 $(document).ready(function(){
        $('.iconThumbnail').click(function(){
             $(this).css('width', function(_ , cur){
              return cur === '100px' ? '100%' : '100px'
            });  // original width is 500px 
        });
    });