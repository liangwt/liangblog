$(function(){
    //为标签附颜色
    var tagClass = ["label-default","label-primary","label-success","label-warning","label-danger","label-info"];

    $("span.blog_tags").each(function(i){
        var index = Math.floor(Math.random()*tagClass.length);
        $(this).addClass(tagClass[index]);
    })
	$('article').readmore({
        speed: 2000,
        maxHeight: 500,
        moreLink:'<a class="btn btn-inverse btn-xs" href="#">Read More <span class="glyphicon glyphicon-chevron-right"></span></a>'
	});
})