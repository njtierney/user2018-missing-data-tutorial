$(document).ready(function() {

    $chunks = $('.hiddensolution');
    $chunks.wrap('<div class=\"hiddensolutioncont\"></div>');
    $chunks.before("<div class=\"showopt\">Show Solution</div><br style=\"line-height:22px;\">");
    $chunks.find('pre.r').find("code").addClass("foldedloc");
    $chunks.find('pre:not(.r)').find("code").addClass("foldedloc");
    $chunks.find("img").addClass("foldedloc");
    $chunks.find("p").addClass("foldedloc");
    $chunks.find("table").addClass("foldedloc");
    $chunks.find(".html-widget").addClass("foldedloc");


    $chunks = $('.hiddencode');
    $chunks.wrap('<div class=\"hiddencodecont\"></div>');
    $chunks.before("<div class=\"showopt\">Show Code</div><br style=\"line-height:22px;\">");
    $chunks.find('pre.r').find("code").wrap('<span class="foldedloc r"></span>');

    $chunks = $('.hiddenoutput');
    $chunks.wrap('<div class=\"hiddencodecont\"></div>');
    $chunks.before("<div class=\"showopt\">Show Output</div><br style=\"line-height:22px;\">");
    $chunks.find('pre:not(.r)').find("code").addClass("foldedloc");
    $chunks.find("img").addClass("foldedloc");
    $chunks.find("table").addClass("foldedloc");
    $chunks.find(".html-widget").addClass("foldedloc");

  // hide all chunks when document is loaded
    $('.foldedloc').css('display', 'none')

  // function to toggle the visibility
  $('.showopt').click(function() {
    var label = $(this).html();
    if (label.indexOf("Show") >= 0) {
      $(this).html(label.replace("Show", "Hide"));
    } else {
      $(this).html(label.replace("Hide", "Show"));
    }
      $(this).siblings().find('.foldedloc').slideToggle('fast','swing')
  });

});
