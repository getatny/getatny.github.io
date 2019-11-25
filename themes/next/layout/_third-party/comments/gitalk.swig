{% if not (theme.duoshuo and theme.duoshuo.shortname) and not theme.duoshuo_shortname %}
{% if theme.gitalk.enable and theme.gitalk.client_id %}

  <link rel="stylesheet" href="https://unpkg.com/gitalk/dist/gitalk.css">
  <script src="https://unpkg.com/gitalk/dist/gitalk.min.js"></script>

  {% if page.comments %}
    <script type="text/javascript">
      const gitalk = new Gitalk({
        clientID: '{{theme.gitalk.client_id}}',
        clientSecret: '{{theme.gitalk.client_secret}}',
        repo: '{{theme.gitalk.repo}}',
        owner: '{{theme.gitalk.owner}}',
        admin: ['{{theme.gitalk.admin}}'],
        id: location.pathname.split('/')[4],
        distractionFreeMode: {{theme.gitalk.distraction_free_mode}},
        labels: ['{{theme.gitalk.labels}}'],
        createIssueManually: {{theme.gitalk.create_issue_manually}}
      })

      gitalk.render('gitalk-container')
    </script>
  {% endif %}

{% endif %}
{% endif %}
