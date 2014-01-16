<?php require_once 'config.php';

if ($env == 'production') {
  error_reporting(E_ERROR | E_PARSE);
}

function print_files($url, $dir)
{
  $hide = ".";

  $myDirectory = opendir($dir);

  if ($myDirectory) {
    while ($entryName = readdir($myDirectory))
    {
      $dirArray[] = $entryName;
    }

    closedir($myDirectory);

    $indexCount = count($dirArray);

    sort($dirArray);

    for ($index = 0; $index < $indexCount; $index++)
    {
      if (substr("$dirArray[$index]", 0, 1) != $hide)
      {
        $name = $dirArray[$index];
        $namehref = $dirArray[$index];
        echo("
          <li>
            <a class='link' href='$url/$namehref'>$name</a>
          </li>
        ");
      }
    }
  } else {
    echo("
      <p class='tac'>Couldn't open the directory specified.</p>
    ");
  }
}
