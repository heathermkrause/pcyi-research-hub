document.observe("click",function(e,t){if(t=e.findElement("form a.add_nested_fields")){var n=t.readAttribute("data-association"),s=t.readAttribute("data-target"),r=$(t.readAttribute("data-blueprint-id")),o=r.readAttribute("data-blueprint"),a=(t.getOffsetParent(".fields").firstDescendant().readAttribute("name")||"").replace(new RegExp("[[a-z_]+]$"),"");if(a){var l=a.match(/[a-z_]+_attributes(?=\]\[(new_)?\d+\])/g)||[],u=a.match(/[0-9]+/g)||[];for(i=0;i<l.length;i++)u[i]&&(o=o.replace(new RegExp("(_"+l[i]+")_.+?_","g"),"$1_"+u[i]+"_"),o=o.replace(new RegExp("(\\["+l[i]+"\\])\\[.+?\\]","g"),"$1["+u[i]+"]"))}var c=new RegExp("new_"+n,"g"),h=(new Date).getTime();o=o.replace(c,h);var d;return d=s?$$(s)[0].insert(o):t.insert({before:o}),d.fire("nested:fieldAdded",{field:d}),d.fire("nested:fieldAdded:"+n,{field:d}),!1}}),document.observe("click",function(e,t){if(t=e.findElement("form a.remove_nested_fields")){var i=t.previous(0),n=t.readAttribute("data-association");i&&(i.value="1");var s=t.up(".fields").hide();return s.fire("nested:fieldRemoved",{field:s}),s.fire("nested:fieldRemoved:"+n,{field:s}),!1}});