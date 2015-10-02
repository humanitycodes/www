## arst

arst

``` js
$('.lesson-slide').find('p, li, h2, h3, h4, h5, h6').on('click', function() {
  // $('.highlighted').removeClass('highlighted');
  // $(this).addClass('highlighted');
  $(this).animate({backgroundColor: 'darkseagreen'}, 1000);
});
```

``` css
.highlighted {
  margin-left: -15px;
  margin-right: -15px;
  padding: 15px;
  background-color: darkseagreen;
}
```

<script>

  (function(){
    $('.lesson-slide').find('p, li, h2, h3, h4, h5, h6').on('click', function() {
      $('.highlighted').removeClass('highlighted');
      $(this).addClass('highlighted');
    });
  })();

</script>

<style>

  .highlighted {
    margin-left: -15px;
    margin-right: -15px;
    padding: 15px;
    background-color: darkseagreen;
  }

</style>
