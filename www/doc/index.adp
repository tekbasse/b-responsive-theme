<master>
<property name="context">{/doc/responsive-theme {responsive-theme}} {Responsive Theme Docs}</property>
<property name="doc(title)">Responsive Theme Documentation</property>

<h1>
Responsive Theme
</h1>
<h2>introduction
</h2>
<p>
This is a responsive theme package for OpenACS web app platform.
It's designed to make OpenACS sites viewable by most small device users as well as desktop users.
An emphasis is placed on using only css as defined by 
OpenACS' default theme, 
Extra Strength Responsive Grid, and
css styles released with openacs-core.
</p>
<h2>license
</h2>
<pre>
Copyright (c) 2015 Benjamin Brink

OpenACS default theme parts are 
Copyright (c) Don Baccus and other contributors to OpenACS's openacs-default-theme

Extra Strength Responsive Grid parts are 
Copyright (c) 2013 John Polacek under Dual MIT & GPL license

b-responsive-theme is open source and published under the GNU General Public License, 
consistent with the OpenACS system: http://www.gnu.org/licenses/gpl.html
A local copy is available at b-responsive-theme/www/doc/LICENSE.html

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
</pre>
<h2>
features
</h2>

<p>
This package is a blend of 
<a href="http://dfcb.github.io/extra-strength-responsive-grids">Extra Strength Responsive Grids</a> 
(ESRG) and OpenACS's default theme from release 5.8
</p>
<p>
Blending mainly consisted of adding the names of existing OpenACS css classes and id's to ESRG's css.
In order to achieve additional style consistency of allowing relative styles to be used repeatedly, 
id's from plain-master have been changed to classes.
</p>
<h2>
installation
</h2>
<p>
  Follow standard OpenACS package installation instructions.
</p><p>
Then update subsite style parameters:
</p>
<ul><li>
DefaultMaster value becomes /packages/b-responsive-theme/lib/plain-master
</li><li>
StreamingHead value becomes /packages/b-responsive-theme/lib/plain-streaming-head
</li><li>
ThemeCSS value becomes {{href /resources/b-responsive-theme/styles/default-master.css} {media all}}
</li></ul>
<p>Consider also modifying OpenACS' blank-master to include a viewport meta tag
  and a few other things in the spirit of the theme. To do this:
</p>
<ol><li>
    Visit the <a href="originals/blank-master-maker">blank-master-maker</a> page to create a revised version of OpenACS' default <code>www/blank-master</code> at <code>packages/b-responsive-theme/www/blank-master</code>.
  </li><li>
    Change the MASTER tag reference in the active plain-master file (<code>b-responsive-theme/lib/plain-master.adp</code>) to:</p>
<code>
  &lt;master "src=/packages/b-responsive-theme/www/plain-master"&gt;
</code>
</li><li>
  Next, change the reference in <code>b-responsive-theme/lib/plain-streaming-head.adp</code> similarly.</p>
</li></ol>
<h3><a id="faqs">FAQs</a></h3>
<p>
How to fix this ambiguous error after changing a site-map's parameters to use a new theme?
</p>
<p><code>
Error: invalid non-positional argument '--href', valid are : -alternate, -href, -media, -title, -lang, -order;
</code></p>
<p>
  This is the result of changing template standards with what is expected with the <strong>ThemeCSS</strong> parameter, and how blank-master interprets ThemeCSS contents. For a quick fix, try replacing the contents of ThemeCSS with:
</p>
<code>
  {{href /resources/b-responsive-theme/styles/default-master.css} {media all}}
</code>
<p>Note the lack of a dash prefixing 'href'.</p>

<h3>Package Maintenance</h3>
<p>
ESRG and openacs-default-theme.css and adp/tcl master templates are expected to evolve.
To help maintain this package, originals css files used for blending
are located in b-responsive-theme/www/doc/originals
and suggested changes to blank-master are in b-responsive-theme/www/.
</p><p>
Use diff between OpenACS originals and their evolved ones to identify changes
that may need to be made to this package.
</p><p>
Alternately, use openacs.org's CVS browser to perform the diff. A link is usually available on the front page at openacs.org.
</p>
<p>
  If OpenACS's default <code>www/blank-master</code> changes from an update. Just re-visit the <tt>blank-master-make</tt> link above to create a new plain-master. The old one will be renamed with a timestamp for reference in case you want to revert.
</p>
