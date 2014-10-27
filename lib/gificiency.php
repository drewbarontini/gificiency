<?php require_once 'config.php';

if ($env == 'production')
{
  error_reporting(E_ERROR | E_PARSE);
}

function print_files($url, $dir)
{
  $hide = ".";

  $directory = opendir($dir);

  if ($directory)
  {
    while ($entry_name = readdir($directory))
    {
      $directory_array[] = $entry_name;
    }

    closedir($directory);

    $index_count = count($directory_array);

    sort($directory_array);

    $json = array();

    for ($index = 0; $index < $index_count; $index++)
    {
      if ( substr("$directory_array[$index]", 0, 1) != $hide )
      {
        $name = $directory_array[$index];
        $name_href = $directory_array[$index];
        $category = get_category($name);
        $json[] = array(
          'name' => $name,
          'url' => $url .'/'. $name_href,
          'category' => $category
        );
        echo("
          <li>
            <a class='link' href='$url/$name_href'>$name</a>
          </li>
        ");
      }
    }
    unlink('gifs.json');
    $fp = fopen('gifs.json', 'w');
    fwrite( $fp, json_encode($json) );
    fclose($fp);
  }
  else
  {
    echo("
      <p class='ptm tac'>Couldn't open the directory specified.</p>
    ");
  }
}

function get_category($name)
{
  if ( preg_match("/-/", $name) )
  {
    $string = explode('-', $name);
    return $string[0];
  }
}
