<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!-- <script>
	(function(b, i, t, C, O, I, N) {
		window.addEventListener('load', function() {
			if (b.getElementById(C))
				return;
			I = b.createElement(i), N = b.getElementsByTagName(i)[0];
			I.src = t;
			I.id = C;
			N.parentNode.insertBefore(I, N);
		}, false)
	})(document, 'script', 'https://widgets.bitcoin.com/widget.js', 'btcwdgt');
</script> -->

<!-- <div style="height: 2px;" class="btcwdgt-price"></div>-->

<security:authorize access="authenticated">
	<div class="container wrapper">
		<div class="page-header text-center web-font">
			<h2>Account Summary</h2>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="panel-group">
					<div class="panel panel-default">
						<div class="panel-heading">
							<a href="#">BitFire Balance <span
								class="glyphicon glyphicon-chevron-right pull-right"
								aria-hidden="true"></span></a>
						</div>

						<div class="panel-body">
							<p>
								<strong>Balance:</strong> ${balance} BTC
							</p>

							<ul style="list-style: none;">
								<li><a href="<c:url value='/user/send' />">Send
										Bitcoin</a></li>
								<li><a href="<c:url value='/user/request' />">Request
										Bitcoin</a></li>
							</ul>
						</div>
					</div>
					<div class="panel panel-default">
						<div class="panel-heading">
							<a href="#">Addresses <span
								class="glyphicon glyphicon-chevron-right pull-right"
								aria-hidden="true"></span></a>
						</div>
						<div class="panel-body">
							<c:forEach items="${addresses}" var="address">
								<div class="row">
									<div class="col-md-5">
										<p>
											<strong></>${address.label}</strong>
										</p>
									</div>
									<div class="col-md-7">
										<p style = "overflow: hidden; text-overflow: ellipsis;">${address.address}</p>
									</div>
								</div>
							</c:forEach>
						</div>
						<div class="panel-footer text-center">
							<a href="<c:url value='/user/wallet' />">Manage Wallet</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-md-8">
				<div class="panel panel-default">
					<div class="panel-heading trans-panel">Transactions</div>

					<div class="panel-body scroll-panel">
						<c:forEach items="${transactions }" var="trans" varStatus="i">
							<div class="panel-group" id="accordion" role="tablist"
								aria-multiselectable="true">
								<div class="panel panel-default">
									<div class="panel-heading trans" role="tab"
										id="heading${i.index}">
										<h4 class="panel-title title">
											<a role="button" data-toggle="collapse"
												data-parent="#accordion" href="#collapse${i.index}"
												aria-expanded="true" aria-controls="collapse${i.index}">
												<div class="row">
													<div class="col-md-4">${trans.date }</div>
													<div class="col-md-5">
														<c:if
															test="${ trans.senderUser.userId eq trans.receiverUser.userId}">
															<td>Self transfer</td>
														</c:if>

														<c:if
															test="${ trans.senderUser.userId ne trans.receiverUser.userId}">
															<c:if test="${user.userId eq trans.senderUser.userId}">
																<td>Sent</td>
															</c:if>
															<c:if test="${ user.userId eq trans.receiverUser.userId}">
																<td>Received</td>
															</c:if>
														</c:if>
													</div>
													<div class="col-md-3">
														<c:if
															test="${ trans.senderUser.userId eq trans.receiverUser.userId}">
															<td><span class="glyphicon glyphicon-plus"
																style="color: #3ea134; top: 4px;" aria-hidden="true"></span>
																${trans.bitcoin}</td>
														</c:if>

														<c:if
															test="${ trans.senderUser.userId ne trans.receiverUser.userId}">
															<c:if test="${user.userId eq trans.senderUser.userId}">
																<td><span class="glyphicon glyphicon-minus"
																	style="color: #ff0000; top: 4px;" aria-hidden="true"></span>
																	${trans.bitcoin}</td>
															</c:if>
															<c:if test="${ user.userId eq trans.receiverUser.userId}">
																<td><span class="glyphicon glyphicon-plus"
																	style="color: #3ea134; top: 4px;" aria-hidden="true"></span>
																	${trans.bitcoin}</td>
															</c:if>
														</c:if>
													</div>
												</div>
											</a>
										</h4>
									</div>
									<div id="collapse${i.index}" class="panel-collapse collapse in"
										role="tabpanel" aria-labelledby="heading${i.index}">

										<div class="panel-body">
											<div class="row">
												<c:if
													test="${ trans.senderUser.userId eq trans.receiverUser.userId}">
													<div class="col-md-3">${trans.receiverUser.username}</div>

												</c:if>
												<c:if
													test="${ trans.senderUser.userId ne trans.receiverUser.userId}">
													<c:if test="${user.userId eq trans.senderUser.userId}">
														<div class="col-md-3">${trans.receiverUser.username}</div>
													</c:if>
													<c:if test="${ user.userId eq trans.receiverUser.userId}">
														<div class="col-md-3">${trans.senderUser.username}</div>
													</c:if>
												</c:if>
												<div class="col-md-1">
													<a href="https://blockchain.info/tx/${trans.txId }">TX</a>
												</div>
												<div class="col-md-3">${trans.bitcoin}BTC</div>
												<div class="col-md-2">${trans.USD}</div>
												<div class="col-md-3">
													<strong>Confirmations:</strong> ${trans.confirmations }
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
					<div class="panel-footer text-center">
						<a href="<c:url value='/user/transactions' />">View All
							Transactions</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</security:authorize>