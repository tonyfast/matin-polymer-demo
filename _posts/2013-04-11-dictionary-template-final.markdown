---
layout: default
title: Dictionary 

---
<div id=main>
{% assign pp = site.data.dictionary %}
<h2>{{ page.title }} </h2>
<p><i>Describe your dictionary here</i></p>
<p class="meta">This page was generated on {{ page.date | date_to_string }} to describe information and knowledge 
generated from 

{% if pp.source[0].url %}
<a href="{{pp.source[0].url}}" target="_blank">
{% endif %}
 
 
 {% if pp.source[0].name == null %}
 	{{pp.source[0].url}}
 {% else %}
 	<b>{{pp.source[0].name}}</b>
 {% endif %}
 
 {% if pp.source[0].url %}
</a>
{% endif %}.  The information was structured into an HDF5 file format using the function 

{% if pp.converter[0].sha %}
<a href="{{pp.converter[0].sha}}" target="_blank">
{% endif %}
 
 
 {% if pp.converter[0].name == null %}
 	{{pp.converter[0].sha}}
 {% else %}
 	<b>{{pp.converter[0].name}}</b>
 {% endif %}
 
 {% if pp.converter[0].sha %}
</a>
{% endif %}.



 </p>


<br>
{% if pp.aggregate %}{% comment %}<h1>Aggregate Group</h1>{% endcomment %}

<div >
    <div id="Aggregate">
        <h1><center><a href="{{pp.url}}#Aggregate" style="font-size:160%;color:black;text-decoration:none;font-variant:small-caps;">Aggregate Information</a></center></h1>
    
    </div>
    <hr>
    
    {% for top in pp.aggregate %}{% comment %}Sub class in spatial{% endcomment %}
    {% for varnm in top.group %}{% comment %}Components of subclass{% endcomment %}
    
    
    {% if varnm.pretty %}      {% comment %}Variables in group{% endcomment %}
    <style="font-size:117%;"><b>
    
    <div id="Aggregate-{{varnm.native}}">
        <h3><a href="{{pp.url}}#Aggregate-{{varnm.native}}" style="font-size:125%;color:#606060;text-decoration:none;font-variant:small-caps;"><i>{{varnm.pretty}}</i></a></h3>
    </div>

    
    </b></style> 
			{% if varnm.unit %}
		({{ varnm.unit }})
		{% else %}
		<code style="font-size:110%;">(No Unit)</code>
		{% endif %}

    
    : describes the variable field <code>{{ varnm.native }}</code><br>
    {% else %}
    <hr>
    <div id="Aggregate-{{varnm.name}}">
        <h3><a href="{{pp.url}}#Aggregate-{{varnm.name}}" style="font-size:125%;color:#606060;text-decoration:none;font-variant:small-caps;"><i>{{varnm.name}}</i></a></h3>
    </div>
    <hr>
    {% endif %}  {% comment %}varnm.pretty{% endcomment %}
    
    {% if varnm.description %}
		&nbsp;&nbsp;&nbsp;{{ varnm.description }}<br>
    {% elsif  varnm.pretty%}
    <i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A description for this variable has not be provided yet.  Please contact the project contributors.</i><br>
    {% endif %}  {% comment %}varnm.description{% endcomment %}
    
    {% if varnm.links and varnm.links[0].name %}
    <style="font-size:117%;"><i>&nbsp;&nbsp;Links</i></style>
    <div style="padding-left: 50px">
    <ol>
        {% for urls in varnm.links %}
        <li>
            {% if urls.name %}
            <a href="{{ urls.url }}" target="_blank">{{ urls.name }}</a>
            {% else %}
            <a href="{{ urls.url }}" target="_blank">{{ urls.url }}</a>
            {% endif %}
            
        </li>
        {% endfor %}
        
    </ol>
    </div>
    {% endif %}{% comment %}varnm.links{% endcomment %}
    
    
    
    {% if varnm.pretty %}
    <br>
    {% else %}
    <hr> 
    {% endif %}        
    {% endfor %}
    {% endfor %}
</div>
{% endif %}





{% if pp.aggregate and pp.spatial %}
<hr>
{% endif %}

<br>
{% if pp.spatial %}{% comment %}<h1>Spatial Group</h1>{% endcomment %}

<div >
    <div id="Spatial">
        <h1><center><a href="{{pp.url}}#Spatial" style="font-size:160%;color:black;text-decoration:none;font-variant:small-caps;">Spatial Information</a></center></h1>
    
    </div>
    <hr>
    
    {% for top in pp.spatial %}{% comment %}Sub class in spatial{% endcomment %}
    {% for varnm in top.group %}{% comment %}Components of subclass{% endcomment %}
    
    
    {% if varnm.pretty %}      {% comment %}Variables in group{% endcomment %}
    <style="font-size:117%;"><b>
    
        <div id="Aggregate-{{varnm.native}}">
        <h3><a href="{{pp.url}}#Aggregate-{{varnm.native}}" style="font-size:125%;color:#606060;text-decoration:none;font-variant:small-caps;"><i>{{varnm.pretty}}</i></a></h3>
    </div>

</b></style> 
			{% if varnm.unit %}
		({{ varnm.unit }})
		{% else %}
		<code style="font-size:110%;">(No Unit)</code>
		{% endif %}

    
    : describes the variable field <code>{{ varnm.native }}</code><br>
    {% else %}
    <hr>
    <div id="Spatial-{{varnm.name}}">
        <h3><a href="{{pp.url}}#Spatial-{{varnm.name}}" style="font-size:125%;color:#606060;text-decoration:none;font-variant:small-caps;"><i>{{varnm.name}}</i></a></h3>
    </div>
    <hr>
    {% endif %}  {% comment %}varnm.pretty{% endcomment %}
    
    {% if varnm.description %}
    <i>&nbsp;&nbsp;&nbsp;{{ varnm.description }}</i><br>
    {% elsif  varnm.pretty%}
    <i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A description for this variable has not be provided yet.  Please contact the project contributors.</i><br>
    {% endif %}  {% comment %}varnm.description{% endcomment %}
    
    {% if varnm.links and varnm.links[0].name %}
    <style="font-size:117%;"><i>&nbsp;&nbsp;Links</i></style>
    <div style="padding-left: 50px">
    <ol>
        {% for urls in varnm.links %}
        {% if urls.name%}
        <li>
            {% if urls.name %}
            <a href="{{ urls.url }}" target="_blank">{{ urls.name }}</a>
            {% else %}
            <a href="{{ urls.url }}" target="_blank">{{ urls.url }}</a>
            {% endif %}
            
        </li>
        {% endif %}
        {% endfor %}
        
    </ol>
    </div>
    {% endif %}{% comment %}varnm.links{% endcomment %}
    
    
    
    {% if varnm.pretty %}
    <br>
    {% else %}
    <hr> 
    {% endif %}        
    {% endfor %}
    {% endfor %}
</div>
{% endif %}
</div>