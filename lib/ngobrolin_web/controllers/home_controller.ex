defmodule NgobrolinWeb.HomeController do
  use NgobrolinWeb, :controller

  alias Ngobrolin.{Content, Youtube}

  def sync(conn, _params) do
    Youtube.sync(Application.get_env(:ngobrolin, :playlist_id))
    dbg(Application.get_env(:ngobrolin, :youtube_api_key))

    conn
    |> put_flash(:info, "Synced successfully")
    |> redirect(to: ~p"/")
  end

  def feed(conn, _params) do
    episodes = Content.list_episodes()

    xml_data =
      """
      <?xml version="1.0"?>
      <rss version="2.0" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
      xmlns:podcast="https://podcastindex.org/namespace/1.0"
      xmlns:atom="http://www.w3.org/2005/Atom"
      xmlns:content="http://purl.org/rss/1.0/modules/content/">
          <channel>
          <title>
          <![CDATA[Ngobrolin WEB]]>
          </title>
          <description><![CDATA[Yuk mari kita diskusi dan ngobrol ngalor-ngidul tentang dunia web. Agar tetap up-to-date dengan teknologi web terkini.

      Topik, tautan dan pertanyaan menarik bisa dilayangkan ke https://bit.ly/ngobrolinweb]]>
          </description>
          <link>https://ngobrol.in/web</link>
          <image>
          <url><![CDATA[https://ngweb-assets.s3.amazonaws.com/thumbnail-podcast-square.jpg]]></url>
          <title>Ngobrolin WEB</title>
          <link>https://ngobrol.in/web</link>
          </image>
          <generator>Podcast Creator</generator>
          <lastBuildDate>Tue, 24 Sep 2024 10:27:25 GMT</lastBuildDate>
          <atom:link href="https://ngobrolinweb.riza.world/feed" rel="self" type="application/rss+xml"/>
          <author>Ngobrolin WEB</author>
          <copyright>
          <![CDATA[Ngobrolin WEB]]>
          </copyright>
          <language>
          <![CDATA[in]]>
          </language>
          <itunes:author>Ngobrolin WEB</itunes:author>
          <itunes:summary><![CDATA[Yuk mari kita diskusi dan ngobrol ngalor-ngidul tentang dunia web. Agar tetap up-to-date dengan teknologi web terkini.

          Topik, tautan dan pertanyaan menarik bisa dilayangkan ke https://bit.ly/ngobrolinweb]]>
          </itunes:summary>
          <itunes:type>episodic</itunes:type>
          <itunes:owner>
          <itunes:name>Ngobrolin WEB</itunes:name>
          <itunes:email>rizafahmi@gmail.com</itunes:email>
          </itunes:owner>
          <itunes:explicit>false</itunes:explicit>
          <itunes:category text="Technology"/>
          <itunes:image href="https://ngweb-assets.s3.amazonaws.com/thumbnail-podcast-square.jpg"/>
          <podcast:locked>no</podcast:locked>
          <podcast:guid>ngweb-podcast-feed</podcast:guid>
          <% import Format %>
          <%= for episode <- @episodes do %>
          <item>
              <title>
              <![CDATA[<%= episode.title %>]]>
              </title>
              <description>
              <![CDATA[<%= episode.description %>]]>
              </description>
              <link>https://s3.amazonaws.com/ngweb-assets/<%= episode.youtube_id %>.mp3</link>
              <pubDate><%= date_format(episode.published_at) %></pubDate>
              <guid isPermaLink="false"><%= episode.id %></guid>
              <enclosure url="https://s3.amazonaws.com/ngweb-assets/<%= episode.youtube_id %>.mp3" length="<%= episode.duration %>" type="audio/mpeg" />
              <itunes:summary>
              <![CDATA[<%= episode.description %>]]>
              </itunes:summary>
              <itunes:duration><%= duration_format(episode.duration) %></itunes:duration>
              <itunes:image href="https://ngweb-assets.s3.amazonaws.com/thumbnail-podcast-square.jpg" />
              <itunes:season>1</itunes:season>
              <itunes:episode><%= episode.episode_number %></itunes:episode>
              <itunes:episodeType>full</itunes:episodeType>
              <itunes:explicit>false</itunes:explicit>
              <podcast:transcript><![CDATA[<%= episode.description %>]]></podcast:transcript>
          </item>
          <% end %>
        </channel>
      </rss>
      """
      |> EEx.eval_string(assigns: [episodes: episodes])

    conn
    |> put_resp_content_type("application/xml")
    |> send_resp(200, xml_data)
  end
end

defmodule Format do
  def date_format(datetime) do
    Timex.format!(datetime, "{WDshort}, {0D} {Mshort} {YYYY} {h24}:{m}:{s} GMT")
  end

  def duration_format(duration) do
    minutes = div(duration, 60)
    seconds = rem(duration, 60)
    "#{minutes}:#{String.pad_leading(Integer.to_string(seconds), 2, "0")}"
  end
end
