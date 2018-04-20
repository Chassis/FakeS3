# Faek S3
A Chassis extension to install and configure Fake S3 on your Chassis server.

## Usage
1. Add this extension to your extensions directory `git clone git@github.com:Chassis/FakeS3.git extensions/fakes3`
2. Run `vagrant provision`.

## Configuration options
You can configure the path on the server and the port used in your chassis config file.
```yaml
fakes3:
  port: 1234
  path: /some/custom/path
```

Depending on how you connect to S3 you may need to set the S3 server path and region.

Check the `local-config.php` for the settings you can define.

Constants are already configured to work with the [S3 Uploads plugin](https://github.com/humanmade/S3-Uploads) so if you use that then there's nothing further to do!
