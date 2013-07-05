<!doctype html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>Gificiency</title>
   <link href="http://fonts.googleapis.com/css?family=Roboto:100" rel="stylesheet" type="text/css">
   <link rel="stylesheet" href="assets/stylesheets/gificiency.css">
</head>
<body class="cell">
  <form class="form" action="">
    <input type="text" name="search" placeholder="Search..." class="search" />
  </form>
  <ul class="links">
    <? require_once 'lib/gificiency.php'; ?>
    <? if ($env == 'development'): ?>
      <? require_once 'lib/seeds.php'; ?>
    <? else: ?>
      <?= print_files($url, $dir); ?>
    <? endif; ?>
  </ul>

  <script src="http://code.jquery.com/jquery-1.10.0.min.js" type="text/javascript"></script>
  <script src="assets/javascripts/vendor/underscore.min.js" type="text/javascript"></script>
  <script src="assets/javascripts/gificiency.js" type="text/javascript"></script>
  <script type="text/javascript">
    $(function() {
      new Gificiency({
        searchField: $('.search'),
        items: $('.links li'),
        links: $('.link')
      });
    });
  </script>

</body>
</html>
