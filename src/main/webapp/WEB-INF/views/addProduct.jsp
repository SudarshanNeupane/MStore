<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<title>Add Product Page</title>
<script src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$('#onAddProductFile').click(function() {
			$('.productFile').fadeIn('slow');
		});

		 var dataContainer = $('#table tbody');
         $("#add").click(function (event) {
             event.preventDefault();
             console.log("check empty: " + $("#txtProductFile").val().length);
             if($("#txtProductFile").val().length < 0){
             	console.log("empty");
             	return;
             }
             $.ajax({
                 url: '${pageContext.request.contextPath}/product/productfile/add',
                 type: 'POST',
                 data: $('#form1').serialize(),
                 success: ajaxSuccess,
					fail:ajaxFailure
             });
         });
             function ajaxSuccess(result) {
             	dataContainer.empty();
                 $.each(result.productFile, function (i, item) {
                     console.log(i + " " + item.name);
                     dataContainer.append($("<tr>")
                    		 .append("<td>"+ parseInt(i+1) + "</td><td>"
                    				 + item.filePath + "</td><td>"+item.fileType+"</td>"));
                 });
             }
             function ajaxFailure(xhr, status, exception) {
                 console.log(xhr, status, exception);
             }
             $("#txtProductFile").val('');
		$('.productFile').fadeOut('slow');
	});

	function selectSubCategory() {

		var categoryId = $("#categoryName").val();
		var dataContainer = $("select#subCategory");
		// 	 alert(categoryName);
		// 	 return false;
		$
				.ajax({
					url : '${pageContext.request.contextPath}/secure/admin/subcategory/listbyid?categoryId='
							+ categoryId,
					type : 'GET',
					success : ajaxSuccess,
					fail : ajaxFailure
				});

		function ajaxSuccess(result) {
			//               alert(result.subCategories);
			dataContainer.empty();
			dataContainer.append($("<option>").append("Select Sub Category"));

			$.each(result.subCategories, function(i, item) {
				console.log(i + " " + item.name);
				dataContainer.append("<option value="+item.id+">"+item.name+"</option>");
			});

		}

		function ajaxFailure() {
			alert("Failure");

		}
	}

	function selectAlbum() {

		var subCategoryId = $("#subCategory").val();
		var dataContainerAlbum = $("select#album");
		$.ajax({
					url : '${pageContext.request.contextPath}/product/album/list?subCategoryId='
							+ subCategoryId,
					type : 'GET',
					success : ajaxSuccessAlbum,
					fail : ajaxFailureAlbum
				});

		function ajaxSuccessAlbum(result) {
			dataContainerAlbum.empty();
			dataContainerAlbum.append($("<option>").append("Select Album"));
			$.each(result, function(i, item) {
				console.log(i + " iiii  " + item.name);
				dataContainerAlbum.append("<option value="+item.id+">"+item.name+"</option>");
			});

		}

		function ajaxFailureAlbum() {
			alert("Failure");

		}
	}
</script>
</head>
<body>

<%-- 	<spring:url value="addProduct" var="action" /> --%>

	<form:form modelAttribute="product"  method="POST">


		<fieldset>
			<legend>Add an Product</legend>

			<table>
				<tr>
					<td><form:errors path="*" cssStyle="color : red;" /></td>
				</tr>

				<tr>
					<td><label for="name">Product Name:</label></td>
					<td><form:input path="name" /></td>
					<td><div style="text-align: center;">
							<form:errors path="name" cssStyle="color : red;" />
						</div></td>
				</tr>

				<tr>
					<td><label for="category.id">Category:</label></td>
					<td><form:select id="categoryName" path="category.id"
							onchange="selectSubCategory()">
							<form:option value="Select Category" />
							<form:options items="${categories}" itemValue="id"
								itemLabel="name" />
						</form:select></td>
					<td><div style="text-align: center;">
							<form:errors path="category.id" cssStyle="color : red;" />
						</div></td>
				</tr>

				<tr>
					<td><label for="subCategory.id">SubCategory:</label></td>
					<td><form:select id="subCategory" path="subCategory.id"
							onchange="selectAlbum()">
							<form:option value="Select Sub Category" />
							<%-- 				    <form:options items="${categories}" itemValue="name" itemLabel="name"/> --%>
						</form:select></td>
					<td><div style="text-align: center;">
							<form:errors path="subCategory.id" cssStyle="color : red;" />
						</div></td>
				</tr>

				<tr>
					<td><label for="album.name">Album:</label></td>
					<td><form:select id="album" path="album.id">
							<form:option value="Select Album" />
							<%-- 				    <form:options items="${categories}" itemValue="name" itemLabel="name"/> --%>
						</form:select></td>
					<td><div style="text-align: center;">
							<form:errors path="album.id" cssStyle="color : red;" />
						</div></td>
				</tr>

				<tr>
					<td><label for="year">Year:</label></td>
					<td><form:input path="year" /></td>
					<td><div style="text-align: center;">
							<form:errors path="year" cssStyle="color : red;" />
						</div></td>
				</tr>



				<tr>
					<td><label for="price">Price:</label></td>
					<td><form:input path="price" /></td>
					<td><div style="text-align: center;">
							<form:errors path="price" cssStyle="color : red;" />
						</div></td>
				</tr>

				<tr>
					<td><label for="length">Length:</label></td>
					<td><form:input path="length" /></td>
					<td><div style="text-align: center;">
							<form:errors path="length" cssStyle="color : red;" />
						</div></td>
				</tr>
				
				 


				<tr>
					<td><button id="onAddProductFile" type="button">Add
							Product File</button></td>
					<td><input type="submit" value="Submit" /></td>
				</tr>



			</table>
			
			 <table id="table">
                <thead>
                    <tr>
                        <th>S.No.</th>
                        <th> Name</th>
                        <th>Type</th>
                    </tr>
                </thead>
                <tbody>
                   
                </tbody>
            </table>

		</fieldset>



	</form:form>


	<div class="productFile">
		<form id="form1">
			<fieldset>
				<legend>Add Product File</legend>

				<table>

					<tr>
						<td><label>Product File: </label></td>
						<td><input type="text" id="txtProductFile" name="name" /></td>
					</tr>


					<tr>
					<td><label>File Type: </label></td>
					<td><select name = "type">
					<c:forEach var="types" items="${filetypes}">
							<option><c:out value="${types}" /></option>
						</c:forEach>
						</select> </td>
					</tr>

					<tr>
						<td>
							<button type="button" id="add">Add</button>
						</td>
					</tr>
				</table>
			</fieldset>
		</form>
	</div>

</body>
</html>