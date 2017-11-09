class hello {
      file { '/tmp/masterSpeaks':
            content => "Hello my agent\n" 
      }
}
