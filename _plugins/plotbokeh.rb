module Jekyll
  class PlotBokeh < Liquid::Tag

    def initialize(tag_name, plotjs, tokens)
      super
      @plotjs = plotjs
    end

    def render(context)
        "<head>
    <link rel=\"stylesheet\" href=\"https://cdn.pydata.org/bokeh/release/bokeh-0.12.4.min.css\" type=\"text/css\" />
            
    <script type=\"text/javascript\" src=\"https://cdn.pydata.org/bokeh/release/bokeh-0.12.4.min.js\"></script>
    <script type=\"text/javascript\">
        Bokeh.set_log_level(\"info\");
    </script>
    <style>
        .hidepc {
            display: none !important;
        }

        .bk-plot-wrapper {
        padding-left:50px;
        }

        .bk-toolbar-wrapper {
            left: 525px !important;
        }

        @media only screen and (max-width: 500px) {
            .bk-plot-wrapper {
                padding-left:10px;
            }
            .bk-canvas {
                height:75% !important;
                width:75% !important;
            }
            .bk-plot-layout, .bk-layout-fixed {
                height: 610px !important;
            }

            .bk-root {
            display: none !important;
            }

            .hidepc {
            display: block !important;
            }
        }
    </style>
</head>

<div class=\"bk-root\">
    <div class=\"bk-plotdiv\" id=\"0ed0fbb6-2c1c-4130-97d7-0285580e0913\"></div>
</div>

<script type=\"text/javascript\" src=\"../bokehplot/#{@plotjs}\"></script>"
    end
  end
end

Liquid::Template.register_tag('plotbokeh', Jekyll::PlotBokeh)