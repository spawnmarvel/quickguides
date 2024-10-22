# https://gsilt.blogspot.com/2018/12/automating-rabbitmq-cluster-deployment.html


# vars for env and path
$env_rmq_dir = "c:\RabbitMqDirectory"
$env_rmq_base = "RABBITMQ_BASE"
$env_rmq_conf = "RABBITMQ_CONFIG_FILE"
$env_rmq_conf_adv = "RABBITMQ_ADVANCED_CONFIG_FILE"
# vars for files
$rmq_file_conf = "rabbitmq.conf"
$rmq_file_conf_path = $env_rmq_dir + "\" + $rmq_file_conf
$rmq_file_conf_adv = "advanced.config"
$rmq_file_conf_adv_path = $env_rmq_dir + "\" + $rmq_file_conf_adv

Write-Host "#### V1.0 Set path's and install RabbitMQ or verify it, .exe must be in same folder as the script. RUN AS ADMIN"

# Must set env before install
# Make a directory for base
if(Test-Path -Path $env_rmq_dir){
    Write-Host "Directory exists: " $env_rmq_dir

}
else {
   Write-Host "Creating directory and configuration files:"
   $rv = New-Item $env_rmq_dir -ItemType Directory
   Write-Host $rv.FullName

   if(Test-Path -Path $rmq_file_conf_path) {
      Write-Host $rmq_file_conf_path
    }
    else {
      Write-Host "Creating $rmq_file_conf_path"
      $rv = New-Item $rmq_file_conf_path
      # Write-Host $rv
      # Default conf is empty, below is good to have
      Set-Content $rmq_file_conf_path "# rabbitmq.conf example : https://github.com/rabbitmq/rabbitmq-server/blob/v3.8.x/deps/rabbit/docs/rabbitmq.conf.example"
      Add-Content $rmq_file_conf_path "`n# advanced.config example: https://github.com/rabbitmq/rabbitmq-server/blob/main/deps/rabbit/docs/advanced.config.example"
      Add-Content $rmq_file_conf_path "`nloopback_users.guest = true"
      Add-Content $rmq_file_conf_path "`nlisteners.tcp.default = 5672"
      Write-Host "Default configured $rmq_file_conf_path"
    }
    if(Test-Path -Path $rmq_file_conf_adv_path ) {
      Write-Host $rmq_file_conf_adv_path 
    }
    else {
      Write-Host "Creating $rmq_file_conf_adv_path"
      $rv =New-Item $rmq_file_conf_adv_path
      # Write-Host $rv
      # Default advanced parameters
      Set-Content $rmq_file_conf_adv_path  "[]."
      Write-Host "Default configured $rmq_file_conf_adv_path"
    }
   
}

# Add base to path
$env_rmq_base_home = [System.Environment]::GetEnvironmentVariable($env_rmq_base, "Machine")

if ($env_rmq_base_home -eq $null) 
{
   Write-Host "Adding to path: " $env_rmq_base
   Write-Host $env_rmq_dir
   $rv = [System.Environment]::SetEnvironmentVariable($env_rmq_base,$env_rmq_dir,'Machine')
   Write-Host $rv
   
}
else {
   Write-Host $env_rmq_base " : " $env_rmq_base_home
  
}

# Add conf to path
$env_rmq_conf_home = [System.Environment]::GetEnvironmentVariable($env_rmq_conf, "Machine")

if ($env_rmq_conf_home -eq $null) 
{
   Write-Host "Adding to path: " $env_rmq_conf
   $tmp_conf = $env_rmq_dir + "\rabbitmq.conf"
   Write-Host $tmp_conf
   $rv = [System.Environment]::SetEnvironmentVariable($env_rmq_conf,$tmp_conf,'Machine')
   Write-Host $rv
}

else {
   Write-Host $env_rmq_conf " : " $env_rmq_conf_home
}

# Add adv conf to path
$env_rmq_conf_adv_home = [System.Environment]::GetEnvironmentVariable($env_rmq_conf_adv, "Machine")

if ($env_rmq_conf_adv_home -eq $null) 
{
   Write-Host "Adding to path: " $env_rmq_conf_adv
   $tmp_conf_adv = $env_rmq_dir + "\advanced.config"
   Write-Host $tmp_conf_adv
   $rv = [System.Environment]::SetEnvironmentVariable($env_rmq_conf_adv,$tmp_conf_adv,'Machine')
   Write-Host $rv
}
else {
   Write-Host $env_rmq_conf_adv " : " $env_rmq_conf_adv_home

}


# Check if Rabbitmq is installed
$service = Get-Service -Name RabbitMQ -ErrorAction SilentlyContinue
# if($service -eq $null)
if ($null -eq $service) {
    # Service does not exist
    Write-Host "RabbitMQ not found, need to install it"
    # set env rabbitmq.conf
    # advancec.config
    # C:\> rabbitmq-server-2.7.1.exe /S
    # enable plugins
    # https://stackoverflow.com/questions/39201172/how-to-install-rabbitmq-silent
}
else {
    # Service does exist
    Write-Host "RabbitMQ is installed"
    
}
