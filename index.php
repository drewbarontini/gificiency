<!doctype html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>Gificiency</title>
   <link href="http://fonts.googleapis.com/css?family=Roboto:100" rel="stylesheet" type="text/css">
   <link rel="stylesheet" href="assets/gificiency.css">
</head>
<body class="cell">
  <form action="">
    <input type="text" name="search" placeholder="Search..." class="search" />
  </form>
  <ul>
    <?php
      require_once 'gificiency.php';
      print_files($url, $dir);
    ?>
  </ul>

  <script src="http://code.jquery.com/jquery-1.10.0.min.js" type="text/javascript"></script>
  <script src="assets/underscore.min.js" type="text/javascript"></script>
  <script src="assets/gificiency.js" type="text/javascript"></script>
  <script type="text/javascript">
    $(function() {
      Gificiency.init();
    });
  </script>

</body>
</html>
