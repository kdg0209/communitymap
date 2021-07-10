 <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
 
 <!-- Bootstrap -->
 <script src="../../resources/assets/js/bootstrap.bundle.min.js"></script>
 <!-- Load jQuery require for isotope -->
 <script src="../../resources/assets/js/jquery.min.js"></script>
 <!-- Isotope -->
 <script src="../../resources/assets/js/isotope.pkgd.js"></script>
 <!-- Page Script -->
 <script>
     $(window).load(function() {
         // init Isotope
         var $projects = $('.projects').isotope({
             itemSelector: '.project',
             layoutMode: 'fitRows'
         });
         $(".filter-btn").click(function() {
             var data_filter = $(this).attr("data-filter");
             $projects.isotope({
                 filter: data_filter
             });
             $(".filter-btn").removeClass("active");
             $(".filter-btn").removeClass("shadow");
             $(this).addClass("active");
             $(this).addClass("shadow");
             return false;
         });
     });
 </script>
 <!-- Templatemo -->
 <script src="../../resources/assets/js/templatemo.js"></script>
 <!-- Custom -->
 <script src="../../resources/assets/js/custom.js"></script>
 
 <script src="../../resources/common/app/plugun/markerSelect/marker.js"></script>