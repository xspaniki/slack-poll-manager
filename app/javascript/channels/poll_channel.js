import consumer from "./consumer"

$(document).on('turbolinks:load', function () {
  consumer.subscriptions.create({
      channel: "PollChannel",
      poll_id: $('#poll-wrapper').attr('data-poll-id')
    }, {
      connected() {
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        let content = JSON.parse(data);
        let answers = $('#chart-wrapper').data('answers');
        let votedAnswer = answers[content.answer_id];
        let consumerPollId = $('#poll-wrapper').data('poll-id');

        if (consumerPollId != content.poll_id) {
          return;
        }

        // Update chart data
        Chartkick.eachChart( function(chart) {
          let actualData = chart.getData()[0].data;
          let newData = actualData.map(function(item) {
            if (votedAnswer == item[0]) {
              item[1]++;
            }

            return [item[0], item[1]];
          });

          chart.updateData(newData);
        });

        // Show toast
        let toastId = `toast-id-${content.id}`;

        $('#sidebar').append(
          `<div class='toast' id='${toastId}' role='alert' aria-live='assertive' aria-atomic='true'>` +
            "<div class='toast-header'>" +
              "<i class='fas fa-poll-h mr-2'></i>" +
              `<strong class='mr-auto'>${votedAnswer}</strong>` +
              `<small class='text-muted'>${new Date(content.created_at).toLocaleString()}</small>` +
            "</div>" +
            "<div class='toast-body' style='background: #EEE;'>" +
              `${content.uid} just voted!` +
            "</div>" +
          "</div>"
        )

        $(`#${toastId}`).toast({ delay: 5000 });
        $(`#${toastId}`).toast('show');
        $(`#${toastId}`).on('hidden.bs.toast', function () {
          $(this).remove();
        });
      }
  });
})
