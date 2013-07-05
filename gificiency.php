<?php require_once 'config.php';

function print_files($url, $dir)
{
  $hide = ".";

  $myDirectory = opendir($dir);

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
}
